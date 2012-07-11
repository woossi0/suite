import logging, json, re, base64, urllib2
from mod_python import apache

log = logging.getLogger('github-post-commit')
log.setLevel(logging.DEBUG)

if len(log.handlers) == 0:
  fh = logging.FileHandler('/var/www/logs/commit.log')
  fh.setLevel(logging.DEBUG)
  fh.setFormatter(logging.Formatter('[%(asctime)s] - %(message)s','%m%d%yT%H:%M'))
  log.addHandler(fh)

def index(req):
  payload = req.form.getfirst('payload')
  log.debug('raw commit data = %s' % payload)
  handle_payload(payload)

def handle_payload(payload, dry=False):
  data = json.loads(payload)
  for c in data['commits']:
    handle_commit(c, dry)

def handle_commit(c, dry=False):
  cid = c['id']
  msg = c['message']
  log.info('processing commit %s, "%s"' % (cid, msg))

  acts = parse_commit(msg)
  for act in acts:
    a,i  = act

    comment = '%s ([%s|%s])' % (c['message'], c['id'], c['url']) 
    if a == "fix" or a == "close":
      fix_in_jira(i, c, comment)
    elif a == "comment":
      comment_in_jira(i, c, comment)

def parse_commit(msg):
  m = re.findall('(fix(?:es|ing)?|close(?:s|ing)?) *#SUITE-(\d+)', msg, re.IGNORECASE)
  if len(m) == 0:
    m = re.findall('#SUITE-(\d+)', msg, re.IGNORECASE)
    for i in range(0, len(m)):
      m[i] = ('comment', m[0])
  else:
    for i in range(0, len(m)):
      m[i] = ('fix', m[i][1])
  return m

def fix_in_jira(iid, commit, comment):
  obj = {}
  obj['transition'] = { 'id': '5' }
  obj['update'] = {'comment': [
    { 'add': { 'body': comment }}
  ]}

  log.info('Resolving issue %s' % iid)
  url = 'http://product.opengeo.org:8080/rest/api/2/issue/SUITE-%s/transitions' % iid
  do_post(url, obj, 204, iid, commit)

def comment_in_jira(iid, commit, comment):
  obj = {'body': comment}
  log.info('Commenting on issue %s' % iid)

  url = 'http://product.opengeo.org:8080/rest/api/2/issue/SUITE-%s/comment' % iid
  do_post(url, obj, 201, iid, commit)

def do_post(url, obj, code, iid, commit):
  cid = commit['id']
  post = json.dumps(obj)

  user = 'opengeo'
  passwd = 'opengeo2012'

  auth = base64.encodestring('%s:%s' % (user,passwd)).replace('\n','')
  req = urllib2.Request(url, post) 
  req.add_header('Authorization', "Basic %s" % auth)
  req.add_header('Content-type', 'application/json')

  try:
    r = urllib2.urlopen(req)
    if r.getcode() != code:
      log.warning('Update SUITE-%s (commit %s) failed, status = %d' 
         % (iid, cid, r.getcode()))
      log.warning(r.read())
  except:
    log.exception('Error updating JIRA, issue SUITE-%s, commit %s' %(iid,cid))

if __name__ == "__main__":
  f = open('x') 
  handle_payload(f.read(), True)


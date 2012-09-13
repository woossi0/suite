.. _dataadmin.pgBasics.serialization:

Serialization
=============

Serialization is the format used for on-disk storage. It is an algorithm for converting in-memory objects to bytes on-disk. Serialization is a contiguous sequence of bytes - good example, is the OGC well-known binary format.

Old implementation of serialization, limited as to the number of new type that coud; be supported. Only room to index in the x/y plane.

New version addresses old version limitations - order the contents of the serialization and expanding a few components - creates more space for new types.

double alignment for coordinates and support for version numbers



















#!/bin/sh

rpmbuild -ba /root/rpmbuild/SPECS/gperftools.spec

cp /root/rpmbuild/RPMS/x86_64/*.rpm /output_rpms

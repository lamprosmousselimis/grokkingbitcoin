#!/bin/bash

# Download and unzip AAPdfMaker into $AAMAKEPDFDIR
#
# git clone git@github.com:habuma/asciidoc-manning-templates.git
# into ${scriptdir}/buildbook

scriptdir=`dirname $0`
sourcedir=${scriptdir}
outputdir=${sourcedir}/build
buildtooldir=${scriptdir}/buildbook
AAMAKEPDFDIR=${buildtooldir}/AAMakePDF
MAKEPDF=${buildtooldir}/makepdf.sh
TEMPLATEDIR=${buildtooldir}/asciidoc-manning-templates

mkdir -p ${outputdir}
ln -sr ${sourcedir}/images ${outputdir}

## AAMakePDF must be run from the AAMakePDF dir
cp ${MAKEPDF} ${AAMAKEPDFDIR}
cp ${buildtooldir}/document.docbook45.erb ${TEMPLATEDIR}
for file in ${sourcedir}/grokking-bitcoin.adoc; do
        basename=`echo $file | sed 's/.*\/\([^\/]*\)\.adoc/\1/'`
	cat $file | asciidoctor -T ${TEMPLATEDIR} -b docbook45 - > ${outputdir}/${basename}.xml

	${AAMAKEPDFDIR}/makepdf.sh ${outputdir}/$basename.xml ${outputdir}/$basename.pdf
done
rm ${scriptdir}/'c:\sw\text.txt'
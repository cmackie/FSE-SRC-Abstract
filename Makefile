fsesrc-submission.pdf: bib-update
	pdflatex fsesrc-submission.tex
	bibtex -min-crossrefs=9999 fsesrc-submission
	pdflatex fsesrc-submission.tex
	pdflatex fsesrc-submission.tex


export BIBINPUTS ?= .:bib
bib:
ifdef PLUMEBIB
	ln -s ${PLUMEBIB} $@
else
	git clone https://github.com/mernst/plume-bib.git $@
endif
.PHONY: bib-update
bib-update: bib
# Even if this command fails, it does not terminate the make job.
# However, to skip it, invoke make as:  make NOGIT=1 ...
ifndef NOGIT
	-(cd bib && git pull && make)
endif

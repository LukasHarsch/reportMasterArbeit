# make Datei fuer LaTeX
# Time-stamp: <2004-12-14 13:25:53 ewi>
# Aufruf: make macht das, was hinter all: steht, bei Bedarf anpassen.
#         make psA5 macht eine ps-Ausgabe in Din A5 Format.
#         make clean loescht alles, was neu erzeugt werden kann.
#         make pdf macht eine pdf-Ausgabe in Din A4 Format.
#         make view zeigt die dvi-Version auf dem Monitor an.
# ganz wichtig: die Befehlszeilen muessen mit einem TAB beginnen!!!

MAINFILE=main
INCLUDEFILES = literatur.bib
LATEXVIEW = xdvi
LATEXPDFVIEW = okular 
GLOSSARGEN = main.nlo -s nomencl.ist -o main.nls

dvi: ${MAINFILE}.dvi
	${LATEXVIEW} ${MAINFILE}.dvi
psA5: ${MAINFILE}.dvi
	dvips -o ${MAINFILE}.ps ${MAINFILE}.dvi
	psnup -2 ${MAINFILE}.ps > ${MAINFILE}A5.ps
	rm ${MAINFILE}.ps

#pdf: ${MAINFILE}.tex ${INCLUDEFILES}
#	pdflatex ${MAINFILE}.tex
#	pdflatex ${MAINFILE}.tex
pdf: ${MAINFILE}.dvi
	dvipdf ${MAINFILE}.dvi
	${LATEXPDFVIEW} ${MAINFILE}.pdf

view: ${MAINFILE}.dvi
	${LATEXVIEW} ${MAINFILE}.dvi

#optional
#makeindex ${GLOSSARGEN}
${MAINFILE}.dvi: ${MAINFILE}.tex ${INCLUDEFILES}
	latex ${MAINFILE}
	latex ${MAINFILE}
	bibtex ${MAINFILE}
	latex ${MAINFILE}
	latex ${MAINFILE}
	latex ${MAINFILE}

clean:
	rm -f *.aux *.log *.toc *.bbl *.blg *.ind *.idx *.ilg *.dvi *.lof *.lol *.lot *.nlo *.nls *.tcp *.tps *.out
	rm -f *~
	rm -f $(MAINFILE).{dvi,ps,pdf}

# vim: ft=make
.PHONY: midterm2._graphics
midterm2.aux midterm2.aux.make midterm2.d midterm2.pdf: $(call path-norm,/usr/share/texlive/texmf-dist/tex/latex/amsfonts/amsfonts.sty)
midterm2.aux midterm2.aux.make midterm2.d midterm2.pdf: $(call path-norm,/usr/share/texlive/texmf-dist/tex/latex/base/article.cls)
midterm2.aux midterm2.aux.make midterm2.d midterm2.pdf: $(call path-norm,/usr/share/texlive/texmf-dist/tex/latex/preprint/fullpage.sty)
midterm2.aux midterm2.aux.make midterm2.d midterm2.pdf: $(call path-norm,/usr/share/texlive/texmf-dist/tex/latex/tools/enumerate.sty)
midterm2.aux midterm2.aux.make midterm2.d midterm2.pdf: $(call path-norm,midterm2.tex)
.SECONDEXPANSION:

# vim: ft=make
.PHONY: hw2._graphics
hw2.aux hw2.aux.make hw2.d hw2.pdf: $(call path-norm,/usr/share/texlive/texmf-dist/tex/latex/amsfonts/amsfonts.sty)
hw2.aux hw2.aux.make hw2.d hw2.pdf: $(call path-norm,/usr/share/texlive/texmf-dist/tex/latex/base/article.cls)
hw2.aux hw2.aux.make hw2.d hw2.pdf: $(call path-norm,/usr/share/texlive/texmf-dist/tex/latex/preprint/fullpage.sty)
hw2.aux hw2.aux.make hw2.d hw2.pdf: $(call path-norm,/usr/share/texlive/texmf-dist/tex/latex/tools/enumerate.sty)
hw2.aux hw2.aux.make hw2.d hw2.pdf: $(call path-norm,hw2.tex)
.SECONDEXPANSION:

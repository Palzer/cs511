# vim: ft=make
.PHONY: hw1._graphics
hw1.aux hw1.aux.make hw1.d hw1.pdf: $(call path-norm,/usr/share/texlive/texmf-dist/tex/latex/amsfonts/amsfonts.sty)
hw1.aux hw1.aux.make hw1.d hw1.pdf: $(call path-norm,/usr/share/texlive/texmf-dist/tex/latex/base/article.cls)
hw1.aux hw1.aux.make hw1.d hw1.pdf: $(call path-norm,/usr/share/texlive/texmf-dist/tex/latex/preprint/fullpage.sty)
hw1.aux hw1.aux.make hw1.d hw1.pdf: $(call path-norm,/usr/share/texlive/texmf-dist/tex/latex/tools/enumerate.sty)
hw1.aux hw1.aux.make hw1.d hw1.pdf: $(call path-norm,hw1.tex)
.SECONDEXPANSION:

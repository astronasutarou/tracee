#!/usr/bin/env perl
$pdflatex         = 'pdflatex %O %S -halt-on-error';
$pdflatex_silent  = 'pdflatex %O %S -halt-on-error -interaction="nonstopmode"';
$bibtex           = 'bibtex';
$makeindex        = 'mendex %O -o %D %S';
$max_repeat       = 5;
$pdf_mode         = 1;
$pvc_view_file_via_temporary = 0;
$pdf_previewer    = "evince";

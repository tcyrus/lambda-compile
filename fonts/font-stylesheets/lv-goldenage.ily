%%%% The stylesheet for LV GOLDENAGE music font and GoldenAge text font
%%%%
%%%% In order for this to work, this file's directory needs to 
%%%% be placed in LilyPond's path
%%%%
%%%% NOTE: If a change in the staff-size is needed, include
%%%% this file after it, like:
%%%%
%%%% #(set-global-staff-size 17)
%%%% \include "lv-goldenage.ily"
%%%%
%%%% Copyright (C) 2014 Abraham Lee (tisimst.lilypond@gmail.com)

\version "2.18.2"

\paper {
  #(define fonts
    (set-global-fonts
    #:music "lv-goldenage"
    #:roman "GoldenAge"
    #:sans "GoldenAge"
    #:factor (/ staff-height pt 20)
  ))
}

\layout {
  \override Staff.Tie.thickness = #2
  \override Staff.Slur.thickness = #2
  \override Staff.PhrasingSlur.thickness = #2
  \override Staff.MultiMeasureRestNumber.font-size = #2
  \override LyricHyphen.thickness = #2
  \override LyricExtender.thickness = #2
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Start with a repeat Barline
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

showStartRepeatBar = { 
  \once \override Score.BreakAlignment.break-align-orders =
        #(make-vector 3 '(instrument-name
                          left-edge
                          ambitus
                          breathing-sign
                          clef
                          key-signature
                          time-signature
                          staff-bar
                          custos))
      \once \override Staff.TimeSignature.space-alist =
        #'((first-note . (fixed-space . 2.0))
           (right-edge . (extra-space . 0.5))
           ;; free up some space between time signature
           ;; and repeat bar line
           (staff-bar . (extra-space . 1)))
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Creating jazz-style repeats
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%=> http://lsr.di.unimi.it/LSR/Item?id=753
#(define (white-under grob) (grob-interpret-markup grob 
  (markup #:vcenter #:whiteout #:pad-x 1 (ly:grob-property grob 'text))))

inlineMMR = {
  \once \override MultiMeasureRest.layer = #-2
  \once \override MultiMeasureRestNumber.layer = #-1
  \once \override MultiMeasureRestNumber.Y-offset = #0
  \once \override MultiMeasureRestNumber.stencil = #white-under
  \once \override MultiMeasureRest.rotation = #'(2 0 0)
}



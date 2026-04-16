#import "@preview/diatypst:0.9.1": *
#import "common.typ": *

#show: slides.with(
  theme: "normal",
  title-color: light-blue,
  count: "dot",
  toc: false,
  ratio: 16 / 9,
  title: "Raspberry Pi Onramp",
  // subtitle: "All you need to know about the Raspberry Pi",
  date: datetime.today().display("[year]-[month]-[day]"),
  authors: "Abdelbacet Mhamdi",
)

#include "parts/rpi.typ"
#include "parts/jl.typ"
#include "parts/ec.typ"

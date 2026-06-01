---
title: The Day FORTRAN Made Sense
date: 2026-05-31 21:46 -0400
categories: [software]
tags: [history]
---
I used to work in physical simulation of jet engines on supercomputers. Fortran was one of the languages of choice due to being very efficient while still being usable by the physics and math people.

I always wondered why Fortran was a little loose with its syntax around spaces.

Most languages let you use any amount of whitespace between tokens, so

```
x = 1
```

and

```
x=1
```

are the same thing.

But

```
function x()
```

and

```
fun ction x()
```

are not.

In Fortran, though,

```
GOTO 999
```

and

```
GO TO 999
```

are the same.

Why?

One day I was looking at a punched card.

![punched card](/assets/img/80-column-card-zones.jpg)

Each character is represented by a pattern of holes in a fixed grid. A punch in a specific position corresponds to a specific letter or number printed on the card.

What stood out was what *wasn’t* there.

A space doesn’t have a pattern. There’s no hole to represent it.

An entirely blank card is 80 spaces in a row.

Then it clicked.

A space isn’t a thing in the same way the other characters are. On a punched card, it’s the absence of a hole.

In a system built around fixed-width cards and line-by-line processing, whitespace doesn’t need special handling. It is already the default state of the medium.

That maps directly onto Fortran’s treatment of spaces. Tokens are defined by structure and position, not by the presence or absence of whitespace between characters.

GOTO is GO TO is GOT O, because the boundary between tokens is not defined by spacing in the way modern languages tend to define it.

Don’t forget where you came from, kids.

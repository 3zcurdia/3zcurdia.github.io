---
layout: post
title: "8 Reasons Why You Should NOT Shoot in JPEG"
description: "The math behind JPEG compression algorithms and why you should shoot RAW"
date: "2016-07-22T13:47:50-05:00"
tags:
  - math
  - computer science
  - photography
---

One of my hobbies is taking pictures, although I am still learning, with my computer science background I know, that If I want to post process my images I need the RAW files. Why because compression algorithms used today sucks! And no matter how good your camera is, the algorithm will do the same to your images.

## JPEG is NOT Film
JPEG as any other digital format, it will always be digital: a sample of a real world signal(consider pictures as 2D signals). Digital computers are designed to work with samples from an analog signal; which means it skips some of the real world data. The today sampling is good, but it will never be an analog system. On computers to achieve higher quality, you will need more data.

<img class="img-fluid" src="/assets/media/quantization.gif" alt="quantization">

## Compression algorithms
Handling a large amount of data it requires a lot of computing power. Therefore we need to use less to perform better. A very common technique in signal compression is to skip the information that is not human visible, on audio, this is better known as the human perceivable frequency range that goes from 10 Hz to 22kHz, and it could be a shorter depending how damaged your ears are. Since images are 2D signals, the same principle applies by skipping what is not relevant. There are two types of compression algorithms, lossy and lossless, although the lossless algorithms tend to be larger files, they provide better quality. Even when JPEG uses a lossy compression algorithm, it became famous thanks to the internet cause is easy to manipulate and small. In 2000 the Joint Photographic Experts Group developed a new JPEG format with the intention of superseding their original standard (created in 1992) with a newly designed, wavelet-based method. Unfortunately, the new JPEG2000 did not achieve the reach of its predecessor.

<img class="img-fluid" src="/assets/media/jpeg2000.png" alt="jpeg2000">

## Discrete cosine transform
The base algorithm for JPEG and MPEG formats it discard high-frequencies, by taking the real component (see [complex numbers](https://en.wikipedia.org/wiki/Complex_number)) from the Discrete Fourier Transform. The DFT it transforms a signal into to their frequencies, and it makes a spectral manipulation simpler Also, there is a faster version for the DFT algorithm called Fast Fourier Transform (FFT) which is extremely popular and relatively easy to implement in any programming language. The popularity and performance of this transformation it sacrifices image/audio quality, but when the JPEG format it was released the computer resources were limited, and performance matter most.

## JPEG Manipulation
Since JPEG lose some signals, the following transformations applied in a post-processing step will take desitions with the available data. At this point, we already missed the complex frequency component, and the following mathematical transformations will do what they can with the available information. Having a RAW file, it enables the post processing software to use the full range of colors and frequencies.

## Reveal a picture is a signal equalization
Reveal an image in CameraRaw, Lightroom or any other software, it is merely a process of equalization. As in audio, we configure our preferences with the bass, middle, and treble frequencies as we please. This is the same with images, we equalize according to our style if we like more or less contrast, blacks, shadows, whites, highlights, etc. If we use a JPEG, there will be a gap in our frequencies, to equalize. Yes! You will have a decent result, but not with the fully potential of our RAW image.

<img class="img-fluid" src="/assets/media/equalizer.jpg" alt="equalizer">


## Moore's Law made storage cheaper
RAW files are huge, but it is also our storage capability today, and that is because Moore's Law which refers that the number of transistors per square inch on integrated circuits will double every year. Remember when you had a floppy disk with all your work files? Today that is nothing; our systems crave for more and more, and our storage had become cheaper.
Some engineers believe that we are reaching the end of Moore's law because our physical limitations. We cannot go smaller than the atom because our computers use electrical signals as bit representations 5[v] as 1 and 0 [v] as 0. But that does not mean we reached a storage capacity limit; there are new researches on persisted storage methods, that doesn't involve electrons.

## Computing power
Can you install an entire operative system in your digital camera? NO? Why? The answer is computing power, the software within the camera it must be low powered, small, fast and reliable for that reason they use dedicated processors and software, a thing we call embedded systems. Processing an image within the camera is faster and easy, thanks to JPEG but not because the quality is better than a post processed RAW file.

## Computers are dumb
All image that is desired to be used must pass through a human eye; the revealing process is a thing we being doing from the beginning of photography. Relying 100% on a computer for the whole creative process is dumb and lazy, we should trust our sense of beauty, that is what humans do. Using default filters its ok if you don't know anything about photography, but eventually, you will get bored of the same treatment, and you will want to do it by yourself.

## Conclusion
If you have a decent camera, shoot RAW and find your revealing style. JPEG is a popular file format, and it excellent for distribution proposes but not for processing. Even with all these reasons and you still want to keep using JPEG, try JPEG2000 maybe that is a better fit for you. But if you want to be professional, please use RAW files.
In addition to this Apple has announced the support for RAW files on iOS 10 with that in mind I will surely look forward the mobile Lightroom application, although I am very confident that applications like Instagram will be supporting RAW files eventually, so there is no reason to keep shooting JPEG.

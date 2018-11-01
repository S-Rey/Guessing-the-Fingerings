# Guessing the Fingerings
## Summary 
This repository contains the code of my Master semester project at [EPFL](https://www.epfl.ch).

### Abstract

Musicians can play in different ways in order to get the same note.
There are many reasons why the musician chooses to play a
note with a specific fingering. It could be because of a practical
reason, such as to facilitate the playing, or because of aesthetic
reasons such as aiming to have a certain timbre. To recognize
which string has been used is a difficult exercise, which only a
trained ear can achieve. Our aim was thus to propose a way to find some characteristic of a string within its sound, in order to recognize it when it has been used for playing any note.
The task was to continue the semester project of another student Raphaël Latty, [*Guessing the fingerings*](https://github.com/LCAV/fingerings) with the aim to improve its detection algorithm.
This project mainly focused on the violin, as it is the instrument used to record the samples on which the algorithm has been tested. But the algorithm should work for any instrument which pluck their strings and vary their length to produce sound.

### Summary
The inhamornicity model of the string used was the following:
<p align="center">
  <img src="images/partials-model.png" width="250"/>
</p>
where *B* is defined as:
<p align="center">
  <img src="images/b-model.png" width="150"/>
</p>



This is a MATLAB code which computes the estimated inharmonicity of a given
audio file. It uses simple DFTs and the [MUSIC](https://en.wikipedia.org/wiki/MUSIC_(algorithm)) algorithm.
The DFT is used to first approximate the partials location. As the sample size is not sufficient to get a good estimation of the partials, the aglrithm then refines the peaks locations using the pseudo-spectrum of the MUSIC algorithm


To find the partials location, the algorithm first do a power spectrum on the signal: 
<p align="center">
  <img src="images/power_spectrum.png" width="450"/>
</p>

We see that the partials have approximatively the same distance between each other. To evaluate this distance, we redo a power spectrum on this result, which gives us the following output:

<p align="center">
  <img src="images/powpow-spectrum.png" width="450"/>
</p>

The second peak highlighted in red contains the frequency information of the distance of the partials. We take its maximum and deduce then the approximate location of the partials. After that, the algorithm uses the MUSIC pseudo-spectrum evaluated on the sample as a way of refining the peak locations.

To use it run the test_inharmonicity.mlx with the desired file location in 
the PATH variable. It will take all the aif file in the given folder and stack
their inharmonicity in the Bs variable.



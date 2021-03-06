//load the setup file
("../../Setup/Setup.scd").loadRelative

//chords I, IV and V
//in Major and Minor - re-evaluate for a different scale (using the .choose method)
(
~chords = Pbind(\instrument,\bpfsaw,
	\dur,Pwhite(4.5,7.0,inf),
	\scale,[Scale.minor,Scale.major].choose,
	\degree,Pwrand([[0,2,4],[3,5,7],[4,6,8]],[0.5,0.25,0.25],inf),
	\cfmin,100,
	\cfmax,1500,
	\rqmin,Pexprand(0.02,0.15,inf),
	\atk,Pwhite(2.0,4.5,inf),
	\rel,Pwhite(6.5,10.0,inf),
	\ldb,6,
	\lsf,1000,
	\octave,Pwrand([4,3,5],[0.6,0.3,0.1],inf),
	\amp,Pwhite(0.8,2.0),
	\out,0);
~chords.play;
);
//major/minor scale chords with a fairly melody which meanders around the major/minor scale, but sounds consonant at the vast majority of points
//scale stored in a dictionary key so that it can be used in both Pbinds easily
(
d[\scale] = [Scale.major,Scale.minor].choose;
~chords = Pbind(\instrument,\bpfsaw,
	\dur,Pwhite(4.5,7.0,inf),
	\scale,d[\scale],
	\degree,Pwrand([[0,2,4],[3,5,7],[4,6,8]],[0.5,0.25,0.25],inf),
	\cfmin,100,
	\cfmax,1500,
	\rqmin,Pexprand(0.02,0.15,inf),
	\atk,Pwhite(2.0,4.5,inf),
	\rel,Pwhite(6.5,10.0,inf),
	\ldb,6,
	\lsf,1000,
	\octave,Pwrand([4,3,5],[0.6,0.3,0.1],inf),
	\amp,Pwhite(0.8,2.0),
	\out,0);
~chords.play;
~sinfb = Pbind(\instrument,\sinfb,\scale,d[\scale],\root,0,\octave,[4,5],\degree,Place([0,0,2,[4,5,6],[7,1,2],[6,7,8,9],[10,12,14,15],7,6,5],inf),\dur,Pbjorklund2(Pwhite(6,8),8)/4,\amp,0.4,\fb,0.9,\rel,0.2);
~sinfb.play
);

//ChordProg - house chords with chord names in an array to make a chord sequence...
//Today is gonna be the day that they're gonna throw it back to you...
(
~sinfb = Pbind(\instrument,\sinfb,\scale,Scale.chromatic,\octave,4,\degree,Pseq([\Em7,\G,\Dsus4,\A7sus4].chordProg,inf).stutter(6),\dur,1,\atk,0.8,\amp,0.3,\fb,0.1,\rel,1);
~sinfb.play
)

//giant steps. Apparently.
(
~sinfb = Pbind(\instrument,\sinfb,\scale,Scale.chromatic,\octave,4,\degree,Pseq([\Bmajor7,\D7,\Gmajor7,\Bb7,\Ebmajor7,\Am7,\D7,\Gmajor7,\Bb7,\Ebmajor7,\Gb7,\Bmajor7,\Fm7,\Bb7,\Ebmajor7,\Am7,\D7,\Gmajor7,\Dbm7,\Gb7,\Bmajor7,\Fm7,\Bb7,\Ebmajor7,\Dbm7,\Gbm7].chordProg,inf),\dur,1,\atk,0.1,\amp,0.3,\fb,0.1,\rel,1);
~sinfb.play;
)

//a musical example in context
(
p.clock.tempo = 180/60;
~chords = Pbind(\instrument,\bpfsaw,
	\dur,Pwhite(9.5,15.0,inf),
	\scale,Scale.chromatic,
	\degree,Pxrand([\Em,\Am7,\Bm7].chordProg,inf),
	\cfmin,100,
	\cfmax,1500,
	\detune,Pexprand(0.0001,1),
	\rqmin,Pexprand(0.02,0.15,inf),
	\atk,Pwhite(2.0,4.5,inf),
	\rel,Pwhite(6.5,10.0,inf),
	\ldb,13,
	\lsf,1000,
	\octave,Pwrand([4,5,6],[0.8,0.15,0.05],inf),
	\amp,Pwhite(0.8,1.5),
	\out,0);
~chords.play;
~oh = Pbind(\instrument,\bplay,\buf,d["ch"][0],\dur,Pbjorklund2(Pwhite(10,16),16)/4,\amp,0.4,\pan,0.2,\rate,Pwhite(1.7,2));
~t = Pbind(\instrument,\bplay,\buf,d["t"][0],\dur,Pbjorklund2(Pwhite(10,16),16)/4,\amp,0.8,\pan,-0.2,\rate,2);
~t2 = Pbind(\instrument,\bplay,\buf,d["t"][0],\dur,Pbjorklund2(Pwhite(10,16),16)/4,\amp,0.8,\pan,-0.2,\rate,4);
~k = Pbind(\instrument,\bplay,\buf,d["k"][2],\dur,Pbjorklund2(Pwrand([3,6],[0.8,0.2],inf),8)/4,\amp,1);
~c = Pbind(\instrument,\bplay,\buf,d["c"][0],\dur,4,\amp,4);
~oh.play;~t.play;~k.play;~c.play;~t2.play;
)

//Alternative scales
//Evaluate to select a scale using the ET12 tuning and run it in ascending order, there are a number of scales so evaluate this a bunch of times
//scales are stored in a dictionary to be referred to multiple times within the ~sinfb pbind
(
p.clock.tempo = 1;
d[\scale] = Scale.choose.postln;
~sinfb = Pbind(\instrument,\sinfb,\scale,d[\scale],\octave,4,\degree,Pseq((0..d[\scale].degrees.size-1),inf),\dur,0.25,\amp,0.3,\fb,0.6,\rel,0.3);
~sinfb.play;
)

//Microtonal scales
(
p.clock.tempo = 1;
d[\scale] = [Scale.zamzam,Scale.chromatic24,Scale.partch_o1,Scale.husseini,Scale.zanjaran,Scale.bhairav].choose.postln;
~sinfb = Pbind(\instrument,\sinfb,\scale,d[\scale],\octave,4,\degree,Pseq((0..d[\scale].degrees.size-1),inf),\dur,0.25,\amp,0.3,\fb,0.6,\rel,0.3);
~sinfb.play;
)


//Alternative Tunings
//Chromatic scale in a random tuning - some relatively subtle differences here
(
p.clock.tempo = 1;
d[\scale] = Scale.chromatic(Tuning.choose);
~sinfb = Pbind(\instrument,\sinfb,\scale,d[\scale],\octave,4,\degree,Pseq((0..d[\scale].degrees.size-1),inf),\dur,0.25,\amp,0.3,\fb,0.6,\rel,0.3);
~sinfb.play;
)

//A musical example of alternative tunings
//one of my favourites is the et53 tuning, using it to slightly disturb a central pitch on multiple instruments, sounds really nice in acid-type music
//by selectively deploying et53, a very narrow pitch range can become normal, making large pitch leaps within an octave seem huge when used.
(
p.clock.tempo = 150/60;
d[\scale] = Scale.chromatic(\et53);
l = Pbjorklund2(Pwhite(1,13),16)/4;
//notice the \degree argument - ranges from -8 to +8, but this difference is nowhere near an octave
~ring3 = Pbind(\instrument,\ring1,\f,Pkey(\freq),\scale,d[\scale],\degree,Pwhite(-8,8),\octave,Pwrand([2,3],[0.8,0.2],inf),\dur,l,\d,0.24,\a,Pexprand(10,400),\pan,0,\amp,1.5);
~sn = Pbind(\instrument,\bplay,\buf,d["s"][1],\dur,l,\amp,0.8);
~h = Pbind(\instrument,\bplay,\buf,d["ch"][1],\dur,l,\amp,0.8);
~k = Pbind(\instrument,\bplay,\buf,d["k"][1],\dur,1,\amp,2);
~ring3.play;~sn.play;~h.play;~k.play;
)
//adding more acid lines which diverge even less. Also adding percussion
(
~ring2 = Pbind(\instrument,\ring1,\f,Pkey(\freq),\scale,d[\scale],\degree,Pwhite(-4,4),\octave,5,\dur,l,\d,0.37,\a,Pexprand(1,40),\pan,1,\amp,0.5);
~ring1 = Pbind(\instrument,\ring1,\f,Pkey(\freq),\scale,d[\scale],\degree,Pwhite(-4,4),\octave,4,\dur,l,\d,0.38,\a,Pexprand(1,40),\pan,-1,\amp,0.5);
~ring2.play;~ring1.play;
)
//another acid line that diverges quite a bit. also open hats
(
~oh = Pbind(\instrument,\bplay,\buf,d["oh"][1],\dur,Pseq([0.5,Pseq([1],inf)],inf),\amp,2);
~oh.play;
~ring4 = Pbind(\instrument,\ring1,\f,Pkey(\freq),\scale,d[\scale],\degree,Pwhite(-8,8),\octave,7,\dur,l,\d,0.21,\a,Pexprand(1,100),\pan,1,\amp,0.8);
~ring4.play;
)
//repetive distorted \sinfb riff, using the whole octave
(
~sinfb = Pbind(\instrument,\sinfb,\scale,d[\scale],\octave,[5,6],\degree,Place([0,0,-52,[30,20,10],[52,40,25,20],[10,11,9,3,6],[30,36,39,40]],inf),\dur,0.25,\amp,0.5,\fb,Pwhite(10.5,900.5),\rel,Pexprand(0.1,0.5));
~sinfb.play;
)
//remove percussion
(
~k.stop;~sn.stop;~h.stop;
)


//Harmonic series
//setting up a fundamental frequency as a NodeProxy so that it can be referenced on the fly
(
~r = {75}
)
//a straight run up the harmonic series to 10 partials. Notice how the notes converge the higher up the harmonic series due out perception of frequency being logarithimic
//note that the \freq argument is a multiplation of a Pkr - a BenoitLib addon which references an active NodeProxy inside of a pattern
(
~sinfb = Pbind(\instrument,\sinfb,\freq,Pseq((1..10),inf)*Pkr(~r),\dur,0.25,\amp,0.3,\fb,0.1,\rel,0.3);
~sinfb.play;
)
//modulate the fundamental frequency to modulate the playing of entire scale
(
~r = {SinOsc.kr(0.1).range(75,80)}
)
//raise the fundamental freqency from 75Hz to 1000Hz over two minutes using XLine (note that XLine is used as frequency is logarithmic)
(
~r = {XLine.kr(75,1000,120)}
)

//a run up the harmonic series from 1 to 50 partials - note how close together the notes become
(
~r = {50};
~sinfb = Pbind(\instrument,\sinfb,\freq,Pseq((1..50),inf)*Pkr(~r),\dur,0.25,\amp,0.3,\fb,0.1,\rel,0.3);
~sinfb.play;
)

//Multiple identical harmonic frequency riffs that use a different multiplication of the fundamental frequency
(
~r = {50};
//1x fundamental
~sinfb = Pbind(\instrument,\sinfb,\freq,Pseq((1..20),inf)*(Pkr(~r)),\dur,0.25,\amp,0.3,\fb,0.1,\rel,0.3);
~sinfb.play;
)
(
//2x fundamental
~sinfb2 = Pbind(\instrument,\sinfb,\freq,Pseq((1..20),inf)*(Pkr(~r)*2),\dur,0.25,\amp,0.3,\fb,0.1,\rel,0.3);
~sinfb2.play;
)
(
//4x fundamental
~sinfb3 = Pbind(\instrument,\sinfb,\freq,Pseq((1..20),inf)*(Pkr(~r)*4),\dur,0.25,\amp,0.3,\fb,0.1,\rel,0.3);
~sinfb3.play;
)
(
//8x fundamental
~sinfb4 = Pbind(\instrument,\sinfb,\freq,Pseq((1..20),inf)*(Pkr(~r)*8),\dur,0.25,\amp,0.3,\fb,0.1,\rel,0.3);
~sinfb4.play;
)
//all together to 30:
(
~r = {50};
~sinfb = Pbind(\instrument,\sinfb,\freq,Pseq((1..20),inf)*(Pkr(~r)),\dur,0.25,\amp,0.3,\fb,0.1,\rel,0.3);
~sinfb2 = Pbind(\instrument,\sinfb,\freq,Pseq((1..20),inf)*(Pkr(~r)*2),\dur,0.25,\amp,0.3,\fb,0.1,\rel,0.3);
~sinfb3 = Pbind(\instrument,\sinfb,\freq,Pseq((1..20),inf)*(Pkr(~r)*4),\dur,0.25,\amp,0.3,\fb,0.1,\rel,0.3);
~sinfb4 = Pbind(\instrument,\sinfb,\freq,Pseq((1..20),inf)*(Pkr(~r)*8),\dur,0.25,\amp,0.3,\fb,0.1,\rel,0.3);
)
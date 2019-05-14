# FPGA iPod
This hardware demonstrates a music player implemented on a DE1-SoC development board. 

After an audio file is loaded into flash memory,as well as a pair of headphones and a keyboard connected to the board, 
the song can be played and paused using the `E` and `D` buttons, respectively. 
Playing the song in the forward and reverse directions is toggled with the `F` and `B` buttons.
`R` is used to restart the music player. 
Finally, he song is sped up and slowed down with the `KEY1` and `KEY0` buttons on the DE1.
The LEDs are also used as a volume indicator.

[![IMAGE ALT TEXT HERE](http://img.youtube.com/vi/31jtuOLA0xw/0.jpg)](https://www.youtube.com/watch?v=31jtuOLA0xw)


## Implementation
The flash memory is interfaced with a finite state machine, `flash_fsm`. By default, `flash_fsm` reads from memory at a frequency of 22 kHz and increments the address being read from every time, so that audio samples are output sequentially and the song plays in the forward direction. 

When a request to speed up, slow down, or reset the speed is asserted, the `freq_ctrl` module adjusts the clock divider accordingly and synchronizes the signal with the system clock to avoid metastability issues. 

Meanwhile, requests asserted via keyboard are decoded by the `kbd_fsm` module, and the address being read from is either incremented, decremented, or held depending on whether the request is to play forward, play in reverse, or pause, respectively.

The volume indicator is controlled by a PicoBlaze microprocessor, which takes the audio data as input and outputs directly to the LEDs on the DE1-SoC (not shown in schematic; `simple_ipod_solution.v` for more details).

<img src="https://i.imgur.com/Ms2Js9M.png" width=500>

## Credits
Credit is due to Yair Linn for providing the source files contained in `bin` and `template`, as well as the code in `simple_ipod_solution.v` not under the "my code" header. All other files in `src` and `tb` were written independently by me.

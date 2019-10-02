#
# MS211 Projeto 2
# Authors: Gabriel Previato RA172388
#          Pedro Souza      RA223515
#

[y, fs] = audioread('AudioEco.wav');

# Get length of the audio array
N = length(y);
fs = 8000;

for i = 0:14
  for j = 1:fs
    # In the case whe are in the first secod, copy the frenquencies values
    if i == 0
      x(fs*i + j) = y(fs*i + j);
    else
      # The new frequencie value will be a copy minus the value 1 second delayed
      x(fs*i + j) = y(fs*i + j) - y(fs*(i - 1) + j);;
    endif
  endfor
endfor

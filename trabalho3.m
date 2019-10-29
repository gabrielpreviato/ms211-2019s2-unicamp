#
# MS211 Projeto 3
# Authors: Gabriel Previato RA172388
#          Pedro Souza      RA223515
#

load DadosTreinamento.mat

# Xtr
d = 30;
m = 393;

x = Xtr;
y = ytr;
W = randn(m, d);
b = randn(m, 1);

#function retval = g(w, x, b):
#  retval = tanh(W*x+b);
#endfunction
G = tanh(W*Xtr+b);
A = zeros(d, m);
b = zeros(m);

for i = 1:d
  for j = 1:m
    sum = 0;
    for k = 1:m
      sum = sum + G(i, k)*G(j, k);
    end
    
    A(i, j) = sum;
  end
  
  sum = 0;
  for k = 1:m
    sum = sum + G(i, k)*y(k);
  end
  b(i) = sum;
end
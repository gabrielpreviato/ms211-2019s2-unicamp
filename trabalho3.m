#
# MS211 Projeto 3
# Authors: Gabriel Previato RA172388
#          Pedro Souza      RA223515
#

#function y=RNA(alpha,W,b,x)
#  y=alpha*tanh(W*x+b);
#endfunction

load DadosTreinamento.mat

# Xtr
d = 30;
m = 393;
n = 20;
x = Xtr;
y = ytr;
W = randn(n, d);
b = randn(n, 1);

#function retval = g(w, x, b):
#  retval = tanh(W*x+b);
#endfunction
G = tanh(W*Xtr+b);
A = zeros(n, n);
B = zeros(n,1);

for i = 1:n
  for j = 1:n
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
  B(i) = sum;
end

alpha = A \ B;

result_2 = alpha'*tanh(W*x+b);

function ret = gr(L, y, result_2)
  false_negative = 0;
  malignos_true = 0;
  for i = 1:length(y)
    if y(i) == 1 && result_2(i) <= L
      false_negative = false_negative + 1;
    endif
    
    if y(i) == 1
      malignos_true = malignos_true + 1;
    endif
  end
  
  ret = false_negative / malignos_true
endfunction

result = zeros(200, 1)
for i = 1:200
  result(i) = gr((i/100 - 1), ytr, result_2)
endfor

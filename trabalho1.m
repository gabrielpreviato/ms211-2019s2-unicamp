#
# MS211 Projeto 1
# Authors: Gabriel Previato RA172388
#          Pedro Souza      RA223515
#

# Load data
load DadosProjeto1_TurmaM.mat

# Probability matrices
P = A;
number_students = length(RA);
for i = 1:number_students
  for j = 1:number_students
    # The probability of the student i be indicated by the sutdent j
    # is 1/n if j knows no students or A[i, j] if student j knows
    # at least one student
    if (sum(A(j, :)) == 0)
      P(i, j) = 1 / number_students;
    else
      P(i, j) = A(j, i) / sum(A(j, :));
    endif
  end
end

# Exeercise 1 constants
alfa = 0.85;
vi = 1 / number_students;

v = zeros(number_students, 1);
for i = 1:number_students
  v(i) = vi;
end

# Lienar System
I = eye(number_students);
M = (alfa * P - I);
b = (alfa - 1) * v;
x = M \ b;

# Find the representative and the vice-representative
[representative, index_representative] = max(x);

vice = 0;
index_vice = 0;
for i = 1:number_students
  if (x(i) < representative) && (x(i) > vice)
    vice = x(i);
    index_vice = i;
  endif
end

# Get the representative and the vice-representative RA`s
RA{index_representative}
RA{index_vice}

# Find if the representatives know more people or are known by more people
representative_knows = sum(A(index_representative, :), 2)
knows_representative = sum(A(:, index_representative))
vice_knows = sum(A(index_vice, :), 2)
knows_vice = sum(A(:, index_vice))

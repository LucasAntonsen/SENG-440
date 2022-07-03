# SENG 440 Progress Report: QR Decomposition
By Ty Ellison (V00) and Lucas Antonsen (V00923982)

## Project Specifications: 
Our project shall make use of the C programming language and an ARM-based processor to create a QR Decomposition program. QR decomposition is useful in a variety of problems such as the Least Squares Problem and results in a matrix that is easier to use in certain capacities [1]. Our program shall use the Gram-Schmidt Orthogonalization algorithm.

## Solution Approach:
QR decomposition is where a matrix, $A$, is decomposed to an orthogonal matrix, $Q$, and an upper triangular matrix, $R$, ($A = QR$). A common method to accomplish QR decomposition is through Gram-Schmidt Orthogonalization (GSO) [2].

In GSO, the matrix, $A$, is divided into columns: $A = [a_1 | a_2| \cdots | a_n]$. Then, we have  
$u_1 = a_1,$  
$e_1 = u_1/||u_1||,$  
$u_2 = a_2-(a_2\cdot e_1)e_1,$  
$e_2 = u_2/||u_2||.$  
$u_{k+1} = a_{k+1}-(a_{k+1}\cdot e_1)e_1- \cdots -(a_{k+1}\cdot e_k)e_k,$  
$e_{k+1} = u_{k+1}/||u_{k+1}||$.

Finally,

$$A = [e_1|e_2|\cdots|e_n] 
\begin{bmatrix}
a_{1}\cdot e_1 & a_{2}\cdot e_1 & \cdots & a_{n}\cdot e_1\\
0 & a_{2}\cdot e_2 & \cdots & a_{n}\cdot e_2\\ 
\vdots & \vdots & \ddots & \vdots\\ 
0 & 0 & \cdots & a_{n}\cdot e_n
\end{bmatrix}
= QR$$

GSO is the method we will use for our project.
Work Completed:
We have created a C program, GSO, for our interpretation of the Gram-Schmidt Orthogonalization algorithm (see Appendix). The GSO program shall be used as a base for further optimizations.

In the current version of GSO (see appendix) input is passed via program execution as follows:

./gso.exe file_input rows columns

file_input is the file containing the input matrix for QR decomposition.
rows is the number of rows in the input matrix.
columns is the number of columns in the input matrix.

From the input, the rows and column sizes are initialized and matrices A, A Transpose, Q and R are initialized based on the row and column sizes.

Using the function fscanm, the file input is read and M is filled with the matrix values. The function transpose_m then is used to fill M Transpose with the appropriate values based on M.

Next, the function QR is called which handles the QR decomposition. In QR, the columns of A are iterated through and used to generate u and e, and then the values of R and Q are populated.

A variety of functions are used in QR. Vec_copy copies a vector represented as an array to another vector. L2_norm generates the constant value of a given vector. Vec_div divides a vector by a constant. Vec_dot generates the dot product of two vectors. Vec_mulc multiplies a vector by a constant.

Additional auxiliary functions include sqr_rt, a function for calculating the square root of a number, which is used by l2_norm. Sqr_rt uses the function closest_perfect_square to ensure that sqr_rt function is searching for the closest value to the given input. Sqr_rt also uses the function abs_val for determining if the square root has been found.

The function fprintm prints the matrix from file input. Spec_map is used to select the appropriate formatting for printing various number types. Printm prints matrices, printv prints vectors and openf opens files.

After we create our initial implementation we will measure performance and then optimize in varying steps.
Questions

If we use the Gram-Schmidt algorithm rather than the method demonstrated in the project slides will we possibly run into any issues?

Does the Gram-Schmidt algorithm have any issues with using fixed-point arithmetic?

Are we allowed to use any libraries for the project?

Is input hardcoded into the source code?

References
[1]     B. D. Shaffer, “QR Matrix Factorization,” towardsdatascience.com, Feb. 27,
2020. [Online]. Available: https://towardsdatascience.com/qr-matrix-factorization-15bae43a6b2.
[2]     I. Yanovsky. Author. QR Decomposition with Gram-Schmidt [Online Document]. Available: https://www.math.ucla.edu/~yanovsky/Teaching/Math151B/handouts/GramSchmidt.pdf.

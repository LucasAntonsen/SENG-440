# QR Decomposition in C: Optimizing for ARM920T
## By Lucas Antonsen and Ty Ellison

In the UVic course, **SENG 440: Embedded Systems**, we developed a QR Decomposition program using [Modified Gram-Schmidt Orthogonalization (MGSO)](https://www.laurenthoeltgen.name/post/gram-schmidt/) for the ARM920T processor.

QR decomposition is where a matrix, $A$, is decomposed to an orthogonal matrix, $Q$, and an upper triangular matrix, $R$, i.e. $(A = QR)$.

e.g.

$$A = 
\begin{bmatrix}
12 & -51 & 4\\
6 & 167 & -68\\
-4 & 24 & -41\\
\end{bmatrix}
= \begin{bmatrix}
14 & 21 & -14\\
0 & 175 & -70\\ 
0 & 0 & 35\\
\end{bmatrix}
\begin{bmatrix}
\frac{6}{7} & \frac{-69}{175} & \frac{-58}{175}\\
\frac{3}{7} & \frac{158}{175} & \frac{6}{175}\\ 
\frac{-2}{7} & \frac{6}{35} & \frac{-33}{35}\\
\end{bmatrix}
= QR$$

After implementing the program using MGSO, we performed the following optimizations in the order below to improve the efficiency of the program:

- Loop unrolling
- For loop optimization
- Cache-oblivious matrix transpose
- Math macros
- Operator strength reduction
- Branch reduction.

---

### Directory Description

```asm``` Assembly files corresponding to the various versions of the QR program.  
```data``` Sample input data for the QR program.  
```final_report``` Final report and presentation slides for the QR program.  
```progress_report``` Progress report from midway through course.  
```qr_versions``` Versions of the QR program as optimizations are introduced.  
```src``` Final version of the QR program.  
```stats``` Statistics for the various versions of the QR program when run on the ARM920T.

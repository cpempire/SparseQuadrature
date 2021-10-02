# SparseQuadrature

This MATLAB library implements sparse quadrature rule for high-dimensional integration with Gaussian measures, built based on [Sparse Grid Interpolation Toolbox](https://people.sc.fsu.edu/~jburkardt/m_src/spinterp/spinterp.html) developed by Andreas Klimke. It provides both a-priori (integrand-independent) and a-posteriori (integrand-dependent) construction algorithms to push the integration to very high dimensions (up to 10,000 dimensions tested), which were proposed and analyzed in the paper 

```
@article{chen2018sparse,
  title={Sparse quadrature for high-dimensional integration with Gaussian measure},
  author={Chen, Peng},
  journal={ESAIM: Mathematical Modelling and Numerical Analysis},
  volume={52},
  number={2},
  pages={631--657},
  year={2018},
  publisher={EDP Sciences}
}
```

Depending on the sparsity of the integrand, it can achieve dimension-independent convergence rates and faster convergence than Monte Carlo for high-dimensional integration problems. 

<img src="images/sp-dimension.png" width="50%">
<p>
Index/level in each dimension built by a-priori and a-posteriori construction algorithms using Gauss-Hermite (GH) quadrature, increasing one point (GH1) or double the number of points (GH2) in each level.
</p>
<img src="images/sp-gaussian.png" width="50%">
<p>
Convergence of different quadrature rules including Gauss-Hermite (GH1 and GH2), transformed Gauss–Kronrod–Patteron (tGKP), and Genz–Keister (GK).
</p>
<img src="images/sp-mc.png" width="50%">
<p>
Convergence of sparse quadrature with Genz–Keister (GK) rule compared with that of Monte Carlo for integrand with different sparsity.
</p>

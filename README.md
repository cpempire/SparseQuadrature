# SparseQuadrature

This library implements sparse quadrature rule for high-dimensional integration with Gaussian measures, accompanying the paper 

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
which provides both a-priori (integrand-independent) and a-posteriori (integrand-dependent) construction algorithms to push the integration to infinite dimensions (up to 10,000 dimensions tested). It uses dimension-adaptive anistropic sparse rule as 

![sparse quadrature](images/sparse-quadrature.png)

which achieved dimension-independent convergence rates and faster convergence than Monte Carlo as shown below 
![sparse quadrature](images/sp-dimension.png)
![sparse quadrature](images/sp-gaussian.png)
![sparse quadrature](images/sp-mc.png)

The library is built based on [Sparse Grid Interpolation Toolbox](https://people.sc.fsu.edu/~jburkardt/m_src/spinterp/spinterp.html) developed by Andreas Klimke, Universitaet Stuttgart.

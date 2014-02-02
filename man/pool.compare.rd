\name{pool.compare}
\alias{pool.compare}
\title{Compare two nested models fitted to imputed data}
\usage{
pool.compare(fit1, fit0, data = NULL, method = "Wald")
}
\arguments{
  \item{fit1}{An object of class 'mira', produced by
  \code{with.mids()}.}

  \item{fit0}{An object of class 'mira', produced by
  \code{with.mids()}. The model in \code{fit0} should be a
  submodel of \code{fit1}. Moreover, the variables of the
  submodel should be the first variables of the larger
  model and in the same order as in the submodel.}

  \item{data}{In case of method 'likelihood' it is
  necessary to pass also the original \code{mids} object to
  the \code{data} argument. Default value is \code{NULL},
  in case of method='Wald'.}

  \item{method}{A string describing the method to compare
  the two models.  Two kind of comparisons are included so
  far: 'Wald' and 'likelihood'.}
}
\value{
A list containing several components. Component \code{call}
is that call to the \code{pool.compare} function. Component
\code{call11} is the call that created \code{fit1}.
Component \code{call12} is the call that created the
imputations. Component \code{call01} is the call that
created \code{fit0}. Compenent \code{call02} is the call
that created the imputations. Components \code{method} is
the method used to compare two models: 'Wald' or
'likelihood'. Component \code{nmis} is the number of
missing entries for each variable. Component \code{m} is
the number of imputations. Component \code{qhat1} is a
matrix, containing the estimated coeffients of the \emph{m}
repeated complete data analyses from \code{fit1}. Component
\code{qhat0} is a matrix, containing the estimated
coeffients of the \emph{m} repeated complete data analyses
from \code{fit0}. Component \code{ubar1} is the mean of the
variances of \code{fit1}, formula (3.1.3), Rubin (1987).
Component \code{ubar0} is the mean of the variances of
\code{fit0}, formula (3.1.3), Rubin (1987). Component
\code{qbar1} is the pooled estimate of \code{fit1}, formula
(3.1.2) Rubin (1987). Component \code{qbar0} is the pooled
estimate of \code{fit0}, formula (3.1.2) Rubin (1987).
Component \code{Dm} is the test statistic. Component
\code{rm} is the relative increase in variance due to
nonresponse, formula (3.1.7), Rubin (1987). Component
\code{df1}: df1 = under the null hypothesis it is assumed
that \code{Dm} has an F distribution with (df1,df2) degrees
of freedom. Component \code{df2}: df2. Component
\code{pvalue} is the P-value of testing whether the larger
model is statistically different from the smaller submodel.
}
\description{
Compares two nested models after m repeated complete data
analysis
}
\details{
The function is based on the article of Meng and Rubin
(1992). The Wald-method can be found in paragraph 2.2 and
the likelihoodmethod can be found in paragraph 3.  One
could use the Wald method for comparison of linear models
obtained with e.g. \code{lm} (in \code{with.mids()}).  The
likelihood method should be used in case of logistic
regression models obtaind with \code{glm()} in
\code{with.mids()}.  It is assumed that fit1 contains the
larger model and the model in \code{fit0} is fully
contained in \code{fit1}. In case of \code{method='Wald'},
the null hypothesis is tested that the extra parameters are
all zero.
}
\examples{
### To compare two linear models:
imp <- mice(nhanes2)
mi1 <- with(data=imp, expr=lm(bmi~age+hyp+chl))
mi0 <- with(data=imp, expr=lm(bmi~age+hyp))
pc  <- pool.compare(mi1, mi0, method='Wald')
pc$spvalue
#            [,1]
#[1,] 0.000293631
#

### Comparison of two general linear models (logistic regression).
\dontrun{
imp  <- mice(boys, maxit=2)
fit0 <- with(imp, glm(gen>levels(gen)[1] ~ hgt+hc,family=binomial))
fit1 <- with(imp, glm(gen>levels(gen)[1] ~ hgt+hc+reg,family=binomial))
pool.compare(fit1, fit0, method='likelihood', data=imp)}
}
\author{
Karin Groothuis-Oudshoorn and Stef van Buuren, 2009
}
\references{
Li, K.H., Meng, X.L., Raghunathan, T.E. and Rubin, D. B.
(1991). Significance levels from repeated p-values with
multiply-imputed data. Statistica Sinica, 1, 65-92.

Meng, X.L. and Rubin, D.B. (1992). Performing likelihood
ratio tests with multiple-imputed data sets.  Biometrika,
79, 103-111.

van Buuren S and Groothuis-Oudshoorn K (2011). \code{mice}:
Multivariate Imputation by Chained Equations in \code{R}.
\emph{Journal of Statistical Software}, \bold{45}(3), 1-67.
\url{http://www.jstatsoft.org/v45/i03/}
}
\seealso{
\code{\link{lm.mids}}, \code{\link{glm.mids}},
\code{\link{vcov}},
}
\keyword{htest}


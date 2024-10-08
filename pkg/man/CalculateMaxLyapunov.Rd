% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/CalculateLyapunov.R
\name{CalculateMaxLyapunov}
\alias{CalculateMaxLyapunov}
\alias{EstimateMaxLyapunov}
\alias{PlotMaxLyapunov}
\title{Maximum lyapunov exponent}
\usage{
CalculateMaxLyapunov(
  HRVData,
  indexNonLinearAnalysis = length(HRVData$NonLinearAnalysis),
  minEmbeddingDim = NULL,
  maxEmbeddingDim = NULL,
  timeLag = NULL,
  radius = 2,
  theilerWindow = 100,
  minNeighs = 5,
  minRefPoints = 500,
  numberTimeSteps = 20,
  doPlot = TRUE
)

EstimateMaxLyapunov(
  HRVData,
  indexNonLinearAnalysis = length(HRVData$NonLinearAnalysis),
  regressionRange = NULL,
  useEmbeddings = NULL,
  doPlot = TRUE
)

PlotMaxLyapunov(
  HRVData,
  indexNonLinearAnalysis = length(HRVData$NonLinearAnalysis),
  ...
)
}
\arguments{
\item{HRVData}{Data structure that stores the beats register and information related to it}

\item{indexNonLinearAnalysis}{Reference to the data structure that will contain the nonlinear analysis}

\item{minEmbeddingDim}{Integer denoting the minimum dimension in which we shall embed the time series}

\item{maxEmbeddingDim}{Integer denoting the maximum dimension in which we shall embed the time series. Thus,
we shall estimate the correlation dimension between \emph{minEmbeddingDim} and \emph{maxEmbeddingDim}.}

\item{timeLag}{Integer denoting the number of time steps that will be use to construct the 
Takens' vectors. Default: timeLag = 1}

\item{radius}{Maximum distance in which will look for nearby trajectories. Default: radius = 2}

\item{theilerWindow}{Integer denoting the Theiler window:  Two Takens' vectors must be separated by more than
\emph{theilerWindow} time steps in order to be considered neighbours. By using a Theiler window, temporally correlated 
vectors are excluded from the estimations.  Default: theilerWindow = 100}

\item{minNeighs}{Minimum number of neighbours that a Takens' vector must have to be considered
a reference point. Default: minNeighs = 5}

\item{minRefPoints}{Number of reference points that the routine will try to use. The routine stops when it finds 
\emph{minRefPoints} reference points, saving computation time. Default: minRefPoints = 500}

\item{numberTimeSteps}{Integer denoting the number of time steps in which the algorithm will
compute the divergence.}

\item{doPlot}{Logical value. If TRUE (default value), a plot of \eqn{S(t)} Vs  \eqn{t} is shown.}

\item{regressionRange}{Vector with 2 components denoting the range where the function will perform linear regression}

\item{useEmbeddings}{A numeric vector specifying which embedding dimensions should the algorithm use to compute
the maximal Lyapunov exponent.}

\item{...}{Additional plot parameters.}
}
\value{
The \emph{CalculateMaxLyapunov} returns a HRVData structure containing the divergence computations of the 
RR time series under the \emph{NonLinearAnalysis} list.

The \emph{EstimateMaxLyapunov} function estimates the maximum Lyapunov exponent of the 
RR time series  by performing a linear regression
over the time steps' range specified in \emph{regressionRange}.If \emph{doPlot} is TRUE,
a graphic of the regression over the data is shown. The 
results are returned into the \emph{HRVData} structure, under the \emph{NonLinearAnalysis} list.

\emph{PlotMaxLyapunov} shows a graphic of the divergence Vs time
}
\description{
Functions for estimating the maximal Lyapunov exponent of  the RR time series.
}
\details{
It is a well-known fact that close trajectories diverge exponentially fast in a chaotic system. The 
averaged exponent that determines the divergence rate is called the Lyapunov exponent (usually denoted with \eqn{\lambda}{lambda}). 
If \eqn{\delta(0)}{delta(0)} is the distance between two Takens' vectors in the embedding.dim-dimensional space, we expect that the distance
after a time \eqn{t} between the two trajectories arising from this two vectors fulfills:
\deqn{\delta (n) \sim \delta (0)\cdot exp(\lambda \cdot t)}{\delta (n) is.approximately \delta (0) exp(\lambda *t).}
The lyapunov exponent is estimated using the slope obtained by performing a linear regression of 
\eqn{S(t)=\lambda \cdot t \sim log(\delta (t)/\delta (0))}{S(t)=\lambda *t is.approximately log(\delta (t)/\delta (0))} 
on  \eqn{t}. \eqn{S(t)} will be estimated by averaging the divergence of several reference points.

The user should plot \eqn{S(t) Vs t} when looking for the maximal lyapunov exponent and, if for some temporal range
\eqn{S(t)} shows a linear behaviour, its slope is an estimate of the maximal Lyapunov exponent per unit of time. The estimate
 routine allows the user to get always an estimate of the maximal Lyapunov exponent, but the user must check that there is a linear region in the  
\eqn{S(t) Vs t}. If such a region does not exist, the estimation should be discarded.  The user should also
run the method for different embedding dimensions for checking if \eqn{D_1}{D1} saturates.
}
\note{
This function is based on the \code{\link[nonlinearTseries]{maxLyapunov}} function from the 
nonlinearTseries package.

In order to run \emph{EstimateMaxLyapunov}, it
is necessary to have performed the divergence computations before with \emph{ComputeMaxLyapunov}.
}
\examples{
\dontrun{
# ...
hrv.data = CreateNonLinearAnalysis(hrv.data)
hrv.data = CalculateMaxLyapunov(hrv.data,indexNonLinearAnalysis=1,
                                 minEmbeddingDim=5,
                                 maxEmbeddingDim = 5,
                                 timeLag=1,radius=10,
                                 theilerWindow=100, doPlot=FALSE)
PlotMaxLyapunov(hrv.data,indexNonLinearAnalysis=1)
hrv.data = EstimateMaxLyapunov(hrv.data,indexNonLinearAnalysis=1, 
                               regressionRange=c(1,10))
}
}
\references{
Eckmann, Jean-Pierre and Kamphorst, S Oliffson and Ruelle, David and Ciliberto, S and others. Liapunov exponents from time series.
Physical Review A, 34-6, 4971--4979, (1986).

Rosenstein, Michael T and Collins, James J and De Luca, Carlo J.A practical method for calculating largest Lyapunov exponents from small data sets.
Physica D: Nonlinear Phenomena, 65-1, 117--134, (1993).
}
\seealso{
\code{\link[nonlinearTseries]{maxLyapunov}}
}

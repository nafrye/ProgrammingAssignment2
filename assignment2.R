
makeCacheMatrix <- function(x = matrix()) {
##check to see if MASS package is installed and install if it is not

	pkgTest <- function(x)
		{
		    if (!require(x,character.only = TRUE))
    			{
		      install.packages(x,dep=TRUE)
		        if(!require(x,character.only = TRUE)) stop("Package not found")
		        } 
	        }

	pkgTest("MASS")	

##now that MASS is installed
	library(MASS)
        m <- NULL
        set <- function(y) {
                x <<- y
                m <<- NULL
        }
        get <- function() x
        setinv <- function(ginv) m <<- ginv
        getinv <- function() m
        list(set = set, get = get,
             setinv = setinv,
             getinv = getinv)
}

cacheSolve <- function(x, ...) {
        m <- x$getinv()
        if(!is.null(m)) {
                message("getting cached data")
                return(m)
        }
        data <- x$get()
        m <- ginv(data, ...)
        x$setinv(m)
        m
}

 

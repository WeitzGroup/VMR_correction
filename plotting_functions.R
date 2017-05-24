calcRSQ <- function(obs,pred){
  ssTotal <- sum((obs-mean(obs))^2)
  ssResidual <- sum((obs - pred)^2)
  return(1-(ssResidual/ssTotal))
}

insert_minor <- function(major_labs, n_minor,blanks) {labs <- 
  c( sapply( major_labs, function(x) c(x, rep("", blanks) ) ) )
labs[1:(length(labs)-n_minor)]}

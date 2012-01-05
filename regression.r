
# given a single vector, extract slope
# > al3x.slope(c(2,3,4))
al3x.slope = function (v_val) {
  v_val = v_val[!is.na(v_val)] # clean the Na values
  dta = data.frame(y=v_val, x=seq(1, length(v_val)))
  mod = lm(y~x, dta)
  return (as.numeric(mod$coefficients[2]))
}

# given a single vector & value, predict
# > al3x.predict(c(2,3,4), 5)
# > al3x.predict(c(4,3,2), 5)
al3x.predict = function (v_val, val) {
  v_val = v_val[!is.na(v_val)] # clean the Na values
  dta = data.frame(y=v_val, x=seq(1,length(v_val)))
  mod = lm(y~x, dta)
  pred = predict.lm(mod, data.frame(x=val), se.fit = TRUE)
  return (as.numeric(pred$fit))
}

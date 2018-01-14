import Base: *

type Dual{T} <: Real
	r::T # the real part
	d::T # the derivative part

	#function Dual(r::T, d::T)
	#	return new(r,d)
	#end
	
	#function Dual(r::T)
	#	return new(r,0)	#this sets the default derivative as zero, which seems reasonable atm
	#end
end
function getReal(num::Dual)
	return num.r
end

function getDerivative(num::Dual)
	return num.d
end


function finite_differences(f::Function, start, step)
	return (f(start+step) - f(step))/step
end


function +(u::Dual, v::Dual)
	return Dual((u.r + v.r), (u.d+v.d))
end

function *(u::Dual, v::Dual)
	return Dual((u.r*v.r), (u.d *v.r + u.r * v.d))
end

function -(u::Dual, v::Dual)
	return Dual((u.r-v.r), (u.d-r.d))
end

function negate(u::Dual)
	return Dual(-u.r, -u.d)
end

function signum(u::Dual)
	return Dual(signum(u.r),0)
end

function abs(u::Dual)
	return dual(abs(u.r), u.d*(signum(u.r)))
end

function /(u::Dual, v::Dual)
	return Dual((u.r/v.r), ((u.d*v.r - u.r*v.d)/(v.r^2)))
end

function exp(u::Dual)
	return Dual(exp(u.r), (u.d*exp(u.r)))
end

function sqrt(u::Dual)
	return Dual(sqrt(u.r), (u.d/(2*sqrt(u.r))))
end

function log(u::Dual)
	return Dual(log(u.r), (u.r/u.d))
end  

function sin(u::Dual)
	return Dual(sin(u.r), (u.d*cos(u.r)))
end

function cos(u::Dual)
	return Dual(cos(u.r), (-u.d*sin(u.r)))
end

function tan(u::Dual)
	return Dual(tan(u.r), (1/(cos(u.r)^2)))
end

function asin(u::Dual)
	return Dual(asin(u.r), (u.d/(sqrt(1-u.r)^2)))
end

function acos(u::Dual)
	return Dual(acos(u.r), (-u.d/sqrt(1-u.r)^2))
end

function atan(u::Dual)
	return Dual(atan(u.r), (u.d/(1+u.r)^2))
end

function sinh(u::Dual)
	return Dual(sinh(u.r), (u.d*cosh(u.r)))
end

function cosh(u::Dual)
	return Dual(cosh(u.r), (u.d*sinh(u.r)))
end

function tanh(u::Dual)
	return Dual(tanh(u.r), (u.d * (1- (tanh(u.r))^2)))
end

function asinh(u::Dual)
	return Dual(asinh(u.r), (u.d/(sqrt(1 + u.r^2))))
end

function acosh(u::Dual)
	return Dual(acosh(u.r), (u.d/sqrt(u.r^2 -1)))
end

function atanh(u::Dual)
	return Dual(atanh(u.r), (u.d/(1-u.r^2)))
end
	


# okay, let's test this

function f(a,b)
	return a + b
end

a = Dual(4,1)
b = Dual(6,2)

f(a,b)
	


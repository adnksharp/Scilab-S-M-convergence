a = [ ], f = [ ];
tol = 0.5 / 100;
c = 1.0;
mprintf("\tMetodo de convergencia\nf(x) = ");
fx = input("", "s");

x = strsubst(fx, " ", "");
in_k = strstr(x, "x^3");
if in_k ~= "" then
	k = strsplit(x, "x^3");
	if size(k, "*") > 1 then
		if k(1) == "" || k(1) == "+" || k(1) == "-" then
			a(1) = "1";
		else
			a(1) = k(1);
		end
		x = k(2);
	end
else
	a(1) = "0";
end

in_k = strstr(x, "x^2");
if in_k ~= "" then
	k = strsplit(x, "x^2");
	if size(k, "*") > 1 then
		if k(1) == "" || k(1) == "+" || k(1) == "-" then
			a(2) = "1";
		else
			a(2) = k(1);
		end
		x = k(2);
	end
else
	a(2) = "0";
end

in_k = strstr(x, "x");
if in_k ~= "" then
	k = strsplit(x, "x");
	if size(k, "*") > 1 then
		if k(1) == "" || k(1) == "+" || k(1) == "-" then
			a(3) = "1";
		else
			a(3) = k(1);
		end
		x = k(2);
	end
else
	a(3) = "0";
end

if length(x) > 0 then
	a(4) = x;
else
	a(4) = "0";
end

for i = 1:4
	a(i) = strsubst(a(i), "(", "");
	a(i) = strsubst(a(i), ")", "");
	a(i) = strsubst(a(i), "%pi", "3.141592653589");
	a(i) = strsubst(a(i), "%e", "2.718281828459");
	k = strsplit(a(i), "/");
	if size(k, "*") > 1 then
		f(5 - i) = strtod(k(1)) / strtod(k(2));
	else
		k = strsplit(a(i), "*");
		if size(k, "*") > 1 then
			f(5 - i) = strtod(k(1)) * strtod(k(2));
		else
			f(5 - i) = strtod(a(i));
		end
	end
end

mprintf("...\n\n");

k = 1;
xr = 0;
if (f(4) + f(3)) ~= 0 && (f(2) + f(1)) ~= 0 then
	fxi(k) = ( f(4) * xr^3 ) + ( f(3) * xr^2 );
	fxii(k) = -(( f(2) * xr ) + f(1) );
	mprintf("fx1 = (%d*x^3) + (%d*x^2)\n", f(4), f(3));
	mprintf("fx2 = (%d*x) + %d\n", f(2), f(1));
else
	fxi = ( f(4) * xr^3 ) + f(1);
	fxii = -(( f(3) * xr^2 ) + (f(2) * xr) );
	mprintf("fx1 = (%d*x^3) + %d\n", f(4), f(1));
	mprintf("fx2 = (%d*x^2) + (%d*x)\n", f(3), f(2));
end

while 1 then
	k = k + 1;
	xr = xr + c;
	if xr == 0 then
		xr = xr + c;
	end
	if (f(4) + f(3)) ~= 0 && (f(2) + f(1)) ~= 0 then
		fxi(k) = ( f(4) * xr^3 ) + ( f(3) * xr^2 );
		fxii(k) = -(( f(2) * xr ) + f(1) );
	else
		fxi(k) = ( f(4) * xr^3 ) + f(1);
		fxii(k) = -(( f(3) * xr^2 ) + (f(2) * xr) );
	end
	if fxi(k) < fxii(k) then
		if c > 0 then
			c = - c;
		end
	else
		if c < 0 then
			c = - c;
		end
	end
	if abs(fxi(k) - fxii(k)) < tol then
		break;
	end
	if abs(fxi(k) - fxii(k)) >= abs(fxi(k - 1) - fxii(k - 1)) then
		c = c / 2;
	end
end

mprintf("\nf(x) = (%s)x^3 + (%s)x^2 + (%s)x + (%s)\n", string(f(4)), string(f(3)), string(f(2)), string(f(1)));
mprintf("x = %s con %d iteraciones\n", string(xr), k);

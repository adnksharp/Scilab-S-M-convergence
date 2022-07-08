c = 2;
i = 1;
f = 0;
mprintf("Raíz de la función: e^-x - x = 0\n\n");

x = f;
y = exp(f);
while 1
    x = f;
    y = exp(-f);

    if y > x then
        f = f + i;
    elseif y < x then
        f = f - i;
    end
    if abs(x-y) < abs((f+i)-(exp(-(f+i)))) | abs(x-y) < abs((f-i)-(exp(-(f-i))))
        i = i / 2;
    end

    if y == x then
        mprintf("Iteraciones:%d\nx:%f\ny1:%f\ny2:%f\n", c, f, x, y);
        break;
    end
    c = c + 1;
end
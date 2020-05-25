function z = factorial(n)

if n==1
    z = 1;
else
    z = n*factorial(n-1);
end

end

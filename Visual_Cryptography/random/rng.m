%Integers are generated based on probability distribution for large 
%samples. A vector or a matrix of random numbers can be generated between
%given numbers inclusive. The syntax is
%   rn = rng(ll,ul,m,n)
%where
%ll = lower limit of numbers to be generated
%ul = upper limit of numbers to be generated
%m = number of rows of matrix of random numbers to be generated
%n = number of columns of matrix of random numbers to be generated
%rn = random numbers
%For example,
%       rn = rng(1,6,2,4)
%creates a matrix of 2 rows and 4 columns having random numbers from 1 to 6
%inclusive.
%The probability of each number to be generated is equally likely.
function rn = rng(ll,ul,m,n)
%% Random Number Generation
%% Created by: Aamir Alaud-din
%% Created on: 13-01-2012
%%
    if (nargin == 1)
        disp('Lower limit, upper limit, and number of rows are required');
        x = rand(0,0);
    elseif (nargin == 2)
        disp('Lower limit, upper limit, and number of rows are required');
        x = rand(0,0);
    elseif (nargin == 3)
        n = 1;
        bf = ul-ll+1;
        factor1 = 1/bf;
        factor2 = 1/bf;
        factor3 = 1/bf;
        low = 0;
        high = factor1;
        x = rand(m,n);
        x = x';
        con = 0;
        s = 0;
        while con <= (bf*factor1)
            a = find(x > low & x < high);
            x(a) = ll + s;
            s = s + 1;
            low = low + factor1;
            high = high + factor1;
            factor2 = factor2 + factor3;
            con = factor2;
        end
    elseif (nargin == 4)
        bf = ul-ll+1;
        factor1 = 1/bf;
        factor2 = 1/bf;
        factor3 = 1/bf;
        low = 0; 
        high = factor1;
        x = rand(m,n);
        con = 0;
        s = 0;
        while con <= (bf*factor1)
            a = find(x < high & x > low);
            x(a) = ll + s;
            s = s + 1;
            low = low + factor1;
            high = high + factor1;
            factor2 = factor2 + factor3;
            con = factor2;
        end
    end
rn = x;
end
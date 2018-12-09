classdef LMSFilter
    properties
        mu
        order
    end
    methods
        function obj = LMSFilter(mu,order)
            if nargin > 0
                obj.mu = mu;
                obj.order = order;
            else
                error('Please Enter Parameters')
            end
        end
        function [y,e,w] = lms(obj,x,d)
            w = zeros(obj.order,1);
            for n = obj.order : length(d)
                u = x(n:-1:n-obj.order+1);
                y(n)= w' * u;
                e(n) = d(n) - y(n);
                w = w + obj.mu * u * e(n);
            end
        end
    end
end
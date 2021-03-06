classdef LMSFilter
    properties
        mu % step size
        order % filter order
    end
    methods
        function obj = LMSFilter(mu,order)
            if nargin == 2
                obj.mu = mu;
                obj.order = order;
            else
                error('Missing Parameters: Be Sure to Enter Mu and Filter Order')
            end
        end
        function [y,e,w] = lms(obj,x,d)
            w = zeros(obj.order,1); % initialize weights vector to zeros
            for n = obj.order : length(d)
                u = x(n:-1:n-obj.order+1); % pull out window of samples reversed because we are convolving
                y(n)= w' * u; % apply weights to window to obtain one sample of y
                e(n) = d(n) - y(n); % calculate error
                w = w + obj.mu * u * e(n); % update weights
            end
        end
    end
end
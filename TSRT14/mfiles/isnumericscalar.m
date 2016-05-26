function ok=isnumericscalar(x)
%ISNUMERICSCALAR tests if the argument is numeric and scalar
%
% ok=isnumscalar(x)

% Copyright Fredrik Gustafsson
%$ Revision: 27-Apr-2016  $

ok = isnumeric(x) && isscalar(x);

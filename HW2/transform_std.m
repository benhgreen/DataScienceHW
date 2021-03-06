## Copyright (C) 2015 Ben
## 
## This program is free software; you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 3 of the License, or
## (at your option) any later version.
## 
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <http://www.gnu.org/licenses/>.

## -*- texinfo -*- 
## @deftypefn {Function File} {@var{retval} =} transform_std (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Ben <ben@icarus>
## Created: 2015-03-23

function [X] = transform_std(X)

X=X-mean(X(:));

X=X/std(X(:));


endfunction

# BOB git mirror #

BoB is a collaborative assistant for biocuration developed by IHMC together with University of Rochester, Harvard School of Medicine, SIFT, and others. The project is funded by DARPA under the Communication with Computers (CwC) program.

This git repo is a mirror of the TRIPS `bob` CVS module. It is updated manually when we feel the system is relatively stable.

The repo contains several libraries with their own FOSS licenses:

 * The `src/config/lisp/defsystem/defsystem-3.6i/` directory contains a modified, non-standard, non-official version of [MK:DEFSYSTEM](http://www.cliki.net/mk-defsystem) 3.6i. See the comments near the top of `defsystem.lisp` in that directory for its copyright notice and license.
 * `src/Conceptualizer/json-simple-1.1.1.jar` is from [json-simple](https://github.com/fangyidong/json-simple), which uses the [Apache License 2.0](https://www.apache.org/licenses/LICENSE-2.0) (see `licenses/apache-software-license.txt`).
 * `src/Conceptualizer/jblas-1.2.3.jar` is from [jblas](http://jblas.org), which uses a [3-clause BSD license](https://github.com/mikiobraun/jblas/blob/e1de8249b28137fa94a79558ee90ff037fd7c47d/COPYING) (see `licenses/jblas-license.txt`).

The rest of the repository is licensed using the [GPL 2+](http://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html) (see `licenses/gpl-2.0.txt`):

TRIPS BoB system  
Copyright (C) 2016  Institute for Human & Machine Cognition

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

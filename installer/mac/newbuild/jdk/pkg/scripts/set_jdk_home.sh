#!/bin/sh -x
# DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS HEADER.
#
# Copyright (c) 2012, 2016 Oracle and/or its affiliates. All rights reserved.
#
# Oracle and Java are registered trademarks of Oracle and/or its affiliates.
# Other names may be trademarks of their respective owners.
#
# The contents of this file are subject to the terms of either the GNU
# General Public License Version 2 only ("GPL") or the Common
# Development and Distribution License("CDDL") (collectively, the
# "License"). You may not use this file except in compliance with the
# License. You can obtain a copy of the License at
# http://www.netbeans.org/cddl-gplv2.html
# or nbbuild/licenses/CDDL-GPL-2-CP. See the License for the
# specific language governing permissions and limitations under the
# License.  When distributing the software, include this License Header
# Notice in each file and include the License file at
# nbbuild/licenses/CDDL-GPL-2-CP.  Oracle designates this
# particular file as subject to the "Classpath" exception as provided
# by Oracle in the GPL Version 2 section of the License file that
# accompanied this code. If applicable, add the following below the
# License Header, with the fields enclosed by brackets [] replaced by
# your own identifying information:
# "Portions Copyrighted [year] [name of copyright owner]"
#
# If you wish your version of this file to be governed by only the CDDL
# or only the GPL Version 2, indicate your decision by adding
# "[Contributor] elects to include this software in this distribution
# under the [CDDL or GPL Version 2] license." If you do not indicate a
# single choice of license, a recipient has the option to distribute
# your version of this file under either the CDDL, the GPL Version 2 or
# to extend the choice of license to its licensees as provided above.
# However, if you add GPL Version 2 code and therefore, elected the GPL
# Version 2 license, then the option applies only if the new code is
# made subject to such option by the copyright holder.
#
# Contributor(s):

nb_dir=$1
jdk_home=$2

if [ -z "$1" ] || [ -z "$2" ]; then
    echo "usage: $0 nb_dir jdk_home"
    exit
fi

echo Changing 'netbeans_jdkhome' netbeans.conf in $nb_dir
echo 'jdk_home' is $jdk_home

if [ -d "$nb_dir" ] && [ -d "$jdk_home" ]
then
  cd "$nb_dir"
  cd Contents/Resources/NetBeans*/etc
  if [ -f netbeans.conf ]
  then
    echo netbeans.conf found: `pwd`/netbeans.conf
    if  grep -q "^netbeans_jdkhome" netbeans.conf
    then
       echo 'netbeans_jdkhome' has been already set to $jdk_home
    else
        if  grep -q "^#netbeans_jdkhome=\"/path/to/jdk\"" netbeans.conf
        then
            echo Setting 'netbeans_jdkhome' to "$jdk_home"...
            cp netbeans.conf netbeans.conf_orig_jdk
            cat netbeans.conf_orig_jdk  | sed -e 's|#netbeans_jdkhome=\"/path/to/jdk\"|netbeans_jdkhome=\"'$jdk_home'\"|' > netbeans.conf
        fi
    fi
  else
    echo No netbeans.conf in: `pwd`
  fi
fi


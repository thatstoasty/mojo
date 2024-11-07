# ===----------------------------------------------------------------------=== #
# Copyright (c) 2024, Modular Inc. All rights reserved.
#
# Licensed under the Apache License v2.0 with LLVM Exceptions:
# https://llvm.org/LICENSE.txt
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ===----------------------------------------------------------------------=== #
# RUN: %mojo %s

import os
from os.path import commonpath
from testing import assert_equal, assert_raises


def test_common_prefix():
    # Paths with a common prefix
    assert_equal(commonpath("/usr/lib", "/usr/local/lib"), "/usr")
    assert_equal(commonpath("usr/lib", "usr/local/lib"), "usr")


def test_no_common_prefix():
    # Paths without a common prefix
    assert_equal(commonpath("/lib", "/usr/local/lib"), "/")
    assert_equal(commonpath("lib", "usr/local/lib"), "")


def test_mixed_paths():
    # Mixing relative and absolute paths should raise
    with assert_raises(contains="Can't mix absolute and relative paths"):
        _ = commonpath("usr/lib", "/usr/bin")


def main():
    test_common_prefix()
    test_no_common_prefix()
    test_mixed_paths()

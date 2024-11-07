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
from os.path import splitext
from testing import assert_equal


def main():
    head, extension = splitext("/usr/lib/file.txt")
    assert_equal(head, "/usr/lib/file")
    assert_equal(extension, ".txt")

    head, extension = splitext("usr/lib/file.txt")
    assert_equal(head, "usr/lib/file")
    assert_equal(extension, ".txt")

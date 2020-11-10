from dataclasses import dataclass
from typing import List

@dataclass
class Diff:
    position: int
    left: str
    right: str
    
class SequentialDiffer:

    @staticmethod
    def diff(file1: str, file2: str) -> List[Diff]:
        diffs = []
        f1_fd = open(file1, 'r')
        f2_fd = open(file2, 'r')

        file1_content = f1_fd.read()
        file2_content = f2_fd.read()
        for i in range(len(file1_content)):
            if file1_content[i] != file2_content[i]:
                diffs.append(Diff(position=i+1, left=file1_content[i], right=file2_content[i]))
        return diffs

from enum import Enum

class RepoRole(str, Enum):
    admin = "admin"
    author = "author"
    reviewer = "reviewer"
    reader = "reader"  # Renamed from 'user' to match your 'Reader' requirement
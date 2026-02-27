# shared/models/user_repo_link.py
from __future__ import annotations

from enum import Enum
from typing import Optional

from sqlmodel import SQLModel, Field, Column
from sqlalchemy import UniqueConstraint, Index
from sqlalchemy import Enum as SAEnum


class RepoRole(str, Enum):
    admin = "admin"
    author = "author"
    reviewer = "reviewer"
    user = "user"


class UserRepoLink(SQLModel, table=True):
    __tablename__ = "user_repo_links"
    __table_args__ = (
        UniqueConstraint("repo_id", "user_id", name="uq_user_repo"),
        Index("ix_user_repo_user_id", "user_id"),
        Index("ix_user_repo_repo_id", "repo_id"),
    )

    # repo: засега int, после може да стане str (commit hash) без да счупим логиката
    repo_id: int = Field(nullable=False)

    # user: Cognito sub (UUID string) най-често е string
    user_id: str = Field(nullable=False, max_length=64)

    # role: enum
    role: RepoRole = Field(
        sa_column=Column(
            SAEnum(RepoRole, name="repo_role"),
            nullable=False,
        )
    )

    # по желание (много полезно после): surrogate PK за лесни update/delete операции
    id: Optional[int] = Field(default=None, primary_key=True)

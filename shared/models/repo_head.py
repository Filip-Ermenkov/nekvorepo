# shared/models/repo_head.py
from __future__ import annotations

from typing import Optional
from sqlmodel import SQLModel, Field
from sqlalchemy import UniqueConstraint, Index


SHA256_HEX_LEN = 64


class RepoHead(SQLModel, table=True):
    __tablename__ = "repo_heads"
    __table_args__ = (
        UniqueConstraint("repo_id", name="uq_repo_heads_repo_id"),
        Index("ix_repo_heads_repo_id", "repo_id"),
    )

    repo_id: int = Field(nullable=False, primary_key=True)

    # sha256 hex: 64 chars
    latest_hash: str = Field(nullable=False, max_length=SHA256_HEX_LEN)

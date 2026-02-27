from sqlmodel import SQLModel, Field
from sqlalchemy import UniqueConstraint

class RepoHead(SQLModel, table=True):
    __tablename__ = "repo_heads"
    __table_args__ = (
        UniqueConstraint("repo_id", name="uq_repo_heads_repo_id"),
    )

    repo_id: uuid.UUID = Field(
        primary_key=True, 
        sa_column_kwargs={"server_default": text("gen_random_uuid()")}
    )
    latest_hash: str = Field(nullable=False, max_length=64) # SHA-256
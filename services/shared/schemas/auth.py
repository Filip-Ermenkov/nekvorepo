from pydantic import BaseModel, EmailStr
from typing import List, Optional
from shared.constants import RepoRole

class Token(BaseModel):
    access_token: str
    token_type: str

class TokenData(BaseModel):
    user_id: str
    email: Optional[EmailStr] = None
    # We include permissions in the token for the "No Compromise" stateless check
    permissions: List[dict] = [] # e.g., [{"repo_id": 1, "role": "admin"}]

class UserRegister(BaseModel):
    email: EmailStr
    password: str
    full_name: str
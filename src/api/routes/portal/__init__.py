"""Portal API routes package."""
from fastapi import APIRouter

from .cells import router as cells_router
from .versions import router as versions_router
from .tenants import router as tenants_router
from .search import router as search_router
from .reviews import router as reviews_router
from .moderation import router as moderation_router

router = APIRouter()
router.include_router(cells_router)
router.include_router(versions_router)
router.include_router(tenants_router)
router.include_router(search_router)
router.include_router(reviews_router)
router.include_router(moderation_router)

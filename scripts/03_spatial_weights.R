
# ================================
# 3. SPATIAL WEIGHTS
# ================================

coords <- coordinates(data_jp)

# k-NN weights
nb_k4 <- knn2nb(knearneigh(coords, k = 4))
lw_k4 <- nb2listw(nb_k4, style = "W")

nb_k6 <- knn2nb(knearneigh(coords, k = 6))
lw_k6 <- nb2listw(nb_k6, style = "W")

nb_k8 <- knn2nb(knearneigh(coords, k = 8))
lw_k8 <- nb2listw(nb_k8, style = "W")

# Queen / Rook
nb_q <- poly2nb(data_jp, queen = TRUE)
lw_q <- nb2listw(nb_q, style = "W", zero.policy = TRUE)

nb_r <- poly2nb(data_jp, queen = FALSE)
lw_r <- nb2listw(nb_r, style = "W", zero.policy = TRUE)

# Inverse distance
nb_dist_300 <- dnearneigh(coords, 0, 300, longlat = TRUE)
dists <- nbdists(nb_dist_300, coords, longlat = TRUE)
inv_dists <- lapply(dists, function(x) 1/x)
lw_inv_dist <- nb2listw(nb_dist_300, glist = inv_dists, style = "W", zero.policy = TRUE)
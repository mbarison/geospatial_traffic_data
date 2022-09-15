# Main file

csd_layer <- readOGR("D:\\StatCan\\lcsd000b16a_e", layer="lcsd000b16a_e")

crs.geo <- proj4string(csd_layer)

yyz_borders <- spdf_extract_borders(csd_layer, "Toronto", largest.only=TRUE)

temp <- csv2spdf("D:\\StatCan\\tf-ft-eng.csv", "Toronto")

temp <- spTransform(temp, crs.geo)

yyz_geodata <- spdf2geodata(temp, borders=yyz_borders)

lambda_bc <- boxcoxfit(yyz_geodata$data)$lambda

yyz_geodata$data <- yyz_geodata$data ^ lambda_bc

plot.geodata(yyz_geodata)

vario.ex <- variog(yyz_geodata, bin.cloud=TRUE, max.dist=3.25e4, uvec=30)

vario.sph <- variofit(vario.ex, cov.model="spher")
vario.exp <- variofit(vario.ex, cov.model="exp")
vario.mat <- variofit(vario.ex, cov.model="matern", kappa=1)
vario.gau <- variofit(vario.ex, cov.model="gauss")

plot(vario.ex)
lines.variomodel(vario.sph, col="blue")
lines.variomodel(vario.exp, col="red")
lines.variomodel(vario.mat, col="green")
lines.variomodel(vario.gau, col="orange")
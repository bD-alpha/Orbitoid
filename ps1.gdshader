shader_type spatial;
render_mode world_vertex_coords;

void vertex() {
	VERTEX = floor(VERTEX * 5.0) / 5.0;
}


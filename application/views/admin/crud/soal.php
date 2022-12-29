<div class="card-body">
    <div><a href="<?= base_url('admin/soal') ?>" class="btn btn-success">Tambah Data Soal</a></div>
                    <div class="table-responsive mt-3">
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th>No</th>
                                    <th>Soal</th>
                                    <th>Jawaban</th>
                                    <th>Kategori</th>
                                    <th>Opsi</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php $no = 1;
                                foreach ($soal as $d) : ?>
                                    <tr>
                                        <td><?= $no++ ?></td>
                                        <td><?= $d->soal ?></td>
                                        <td><?= $d->jawaban ?></td>
                                        <td><?= $d->kategori ?></td>
                                        <td>
                                            <a class="btn btn-danger" href="<?= base_url('soal/hapus/' . $d->id) ?>">Hapus</a>
                                            <a class="btn btn-primary" href="javascript:void(0)" data-toggle="modal" data-target="#editModal<?= $d->id ?>">Ubah</a>
                                        </td>
                                    </tr>
                                    <div class="modal fade" id="editModal<?= $d->id ?>" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title" id="exampleModalLabel">Ubah Data Soal</h5>
                                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                        <span aria-hidden="true">&times;</span>
                                                    </button>
                                                </div>
                                                <?= form_open('soal/ubah/' . $d->id); ?>
                                                <div class="modal-body">
                                                    <div class="form-group">
                                                        <label>Soal</label>
                                                        <input type="text" name="soal" required class="form-control" value="<?= $d->soal ?>">
                                                    </div>
                                                    <div class="form-group">
                                                        <label>Jawaban</label>
                                                        <input type="text" name="jawaban" required class="form-control" value="<?= $d->jawaban ?>">
                                                    </div>
                                                    <div class="form-group">
                                                        <label>Kategori</label>
                                                        <input type="text" name="kategori" required class="form-control" value="<?= $d->kategori ?>">
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Tutup</button>
                                                        <button type="submit" class="btn btn-primary"> <i class="fa fa-pencil"></i> Ubah Data</button>
                                                    </div>
                                                    <?= form_close(); ?>
                                                </div>
                                            </div>
                                        </div>
                                    <?php endforeach; ?>
                            </tbody>
                        </table>
                    </div>
                </div>
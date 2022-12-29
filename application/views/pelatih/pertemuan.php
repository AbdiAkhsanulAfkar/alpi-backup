<div class="card-body">
    <div class="table-responsive mt-3">
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>No</th>
                    <th>Pertemuan</th>
                    <th>Aksi</th>
                </tr>
            </thead>
            <tbody>
                <?php $no = 1;
                foreach ($pertemuan as $d) : ?>
                    <tr>
                        <td><?= $no++ ?></td>
                        <td><?= $d->pertemuan ?></td>
                        <td>
                        <!-- <form>
                            <input type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter email" value="<?= $d->pertemuan ?>"> -->
                            <a class="btn btn-primary" href="<?= base_url('pelatih/data_absensi/'. $d->pertemuan.'?pertemuan='.$d->pertemuan) ?>">Absensi</a>
                        </td>
                    </tr>
                <?php endforeach; ?>
    </div>
</div>

</tbody>
</table>
</div>
</div>
links:
	cd ~ && \
        for i in `find snotfiles -name "\.*" -type f -d 1 | cut -c 10-`; \
        do echo ln -s snotfiles/$i $i \
        ; done && cd snotfiles
